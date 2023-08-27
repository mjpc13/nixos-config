''watch_dir="/path/to/watch"
destination="/path/to/destination"

inotifywait -m -e create "$watch_dir" |
while read path action file; do
    if [ "$action" = "CREATE" ]; then
        mv "$path$file" "$destination"
        echo "Moved $file to $destination"
    fi
done
''
