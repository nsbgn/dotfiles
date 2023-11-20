import sys
import traceback
from time import time
from typing import Callable, Iterable, Iterator
import i3ipc as i3  # type: ignore
from i3ipc.events import IpcBaseEvent  # type: ignore


class Connection(i3.Connection):
    """Extend `i3ipc`'s `Connection`s with a more ergonomic interface. In 
    particular, the tick event is used to avoid having to reimplement 
    inter-process communication: we can just use `i3msg -t send_tick prefix 
    message` (or `swaymsg`) to pass a message to this process."""

    def __init__(self, prefix: str, *nargs, **kwargs) -> None:
        super().__init__(*nargs, **kwargs)
        self.prefix: str = prefix
        self.reply: dict[str, Callable[..., Iterator[str] | None]] \
            = dict()
        self.on(i3.Event.TICK, Connection._handle_event_tick)
        self.last_msg_command: list[str] = []
        self.last_msg_time: float = time()

    def execute(self, commands: Iterable[str]) -> None:
        """Execute the commands in the given iterator by sending it to i3/sway 
        combined into one message, with any errors shown in stderr."""
        try:
            payload = "; ".join(commands)
            if payload:
                reply = self.command(payload)
                result = reply[0].ipc_data
                if not result["success"]:
                    raise RuntimeError(
                        f"An error occurred for '{payload}': "
                        f"{result['error']}")
        except Exception:
            print(traceback.format_exc(), file=sys.stderr)
            raise

    def _handle_event_tick(self, event: i3.TickEvent) -> None:
        msg = event.payload.split()
        if len(msg) > 1 and msg[0] == self.prefix:  # only relevant messages
            self.last_msg_command = msg
            self.last_msg_time = time()
            command, args = msg[1], msg[2:]
            reaction = self.reply[command](*args)
            if reaction:
                self.execute(reaction)

    def handle_event(self, *events: i3.Event) \
            -> Callable[[Callable[[IpcBaseEvent], Iterator[str]]], None]:
        """Creates a decorator that makes i3/sway execute the messages produced 
        by the original function when the given event occurs."""
        def dec(fn: Callable[[IpcBaseEvent], Iterator[str] | None]) -> None:
            def handler(conn, event):
                reaction = fn(event)
                if reaction:
                    conn.execute(reaction)

            for e in events:
                self.on(e, handler)
        return dec

    def handle_message(self, command: str) -> \
            Callable[[Callable[..., Iterator[str]]], None]:
        """Creates a decorator that makes i3/sway execute the messages produced 
        by the original function when the payload of the `tick` event starts 
        with the given command."""
        def decorator(fn: Callable[..., Iterator[str] | None]) -> None:
            self.reply[command] = fn
        return decorator
