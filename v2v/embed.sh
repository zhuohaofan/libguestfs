#!/bin/bash -
# Embed code or other content into an OCaml file.
# Copyright (C) 2018 Red Hat Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# Embed code or other content into an OCaml file.
#
# It is embedded into a string.  As OCaml string literals have virtually
# no restrictions on length or content we only have to escape double
# quotes for backslash characters.

if [ $# -ne 3 ]; then
    echo "embed.sh identifier input output"
    exit 1
fi

set -e
set -u

ident="$1"
input="$2"
output="$3"

rm -f "$output" "$output"-t

exec >"$output"-t

echo "(* Generated by embed.sh from $input *)"
echo
echo let "$ident" = '"'
sed -e 's/\(["\]\)/\\\1/g' < "$input"
echo '"'

chmod -w "$output"-t
mv "$output"-t "$output"
