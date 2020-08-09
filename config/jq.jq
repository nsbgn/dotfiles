# Format a date into its wordy equivalent.
def format_date:
    try
    (
        (   try (. | strptime("%Y-%m-%d")) 
            catch (
                try (. | strptime("%Y/%m/%d")) 
                catch (
                    try (. | strptime("%Y-%m"))
                )
            )
        ) | mktime | strftime("%B %-d, %Y")
    )
;


# Group an array of objects into an object of arrays, such that the key-value
# pairs of the new object are an accumulation of those of the old object. For
# example, `[{"a":1, "b":2}, {"a":3}]` turns into `{"a":[1, 3], "b":[3]}`. This
# can be used to partition an array.
# Try: `[1,"2",3] | map ({(.|type):.}) | group`
def group:
    reduce ([.[] | to_entries[]] | group_by(.key))[] as $group
    ( {} 
    ; .[ $group[0].key ] |= (. // []) + [ $group[].value ] 
    )
;


# Merge two values. If the values are both objects, the values at equal indices
# will be recursively merged; if the values are both arrays, the arrays are
# concatenated; if the values are some other type, we only check if the values
# do not conflict.
def merge(other): 
    if [ ., other | type == "object"] | all then
        (. | to_entries) + (other | to_entries) 
        | group_by(.key)
        | map({ "key": (.[0].key), "value" : (reduce .[1:][].value as $x (.[0].value; merge($x)))})
        | from_entries
    elif [ ., other | type == "array"] | all then
        . + other
    elif . == other then
        .
    else
        error("trying to merge incompatible objects " + (.|type) + " and " + (other|type))
    end
;
