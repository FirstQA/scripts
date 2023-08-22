#!/bin/bash

# Set the URL to check
url="moneroocean.stream"

# Get the domain from the URL
domain=$(echo $url | awk -F[/:] '{print $4}')

# Check if the log command exists
if command -v log &> /dev/null; then
# Search the log for the domain
if log show --predicate "process == 'mDNSResponder' && eventMessage contains '$domain'" | grep -q "$domain"; then
echo "The user has browsed $url"
else
echo "The user has not browsed $url"
fi
else
echo "The log command does not exist"
fi

# Define the website to check
website="moneroocean.stream"

# Use the `dscacheutil` command to query the DNS cache
cache_entries=$(dscacheutil -q host -a name "$website")

# Count the number of times "google.com" appears in the cache entries
count=$(echo "$cache_entries" | grep -c "$website")

# Print the count
echo "User resolved $website $count times in the DNS cache."