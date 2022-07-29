#!/usr/bin/env sh

echo "# $(basename "$(git rev-parse --show-toplevel)") #" > "$(pwd)/documentation/header.md"
echo "" >> "$(pwd)/documentation/header.md"
echo "*Anything with a \`ⓘ\` is a dropdown containing additional, contextual information.* " >> "$(pwd)/documentation/header.md"
