function process(tag, timestamp, record)
    -- Convert timestamp to RFC3339
    if record.timestamp then
        local year, month, day, hour, min, sec = record.timestamp:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
        if year then
            record.timestamp = string.format("%s-%s-%sT%s:%s:%sZ", year, month, day, hour, min, sec)
        end
    end

    -- Add any additional custom processing here
    -- For example, you might want to add a new field:
    record.processed_by = "fluent-bit"

    return 1, timestamp, record
end