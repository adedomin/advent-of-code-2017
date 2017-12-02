#!/usr/bin/mawk -Wexec
# Copyright (c) 2017 Anthony DeDominic <adedomin@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# See README.md for problem descriptions
# usage ./checksum-2.awk input.txt

{
    evenDiv = ""
    for (i=1; i<=NF; ++i) {
        for (j=1; j<=NF; ++j) {
            if ($i > $j && $i % $j == 0)
                evenDiv = $i / $j
            else if ($i != $j && $j % $i == 0)
                evenDiv = $j / $i
        }
    }

    if (evenDiv == "") {
        min = ""
        max = ""
        for (i=1; i<=NF; ++i) {
            if (min == "" || min > $i) min = $i
            if (max == "" || max < $i) max = $i
        }
        total += max - min
    }
    else {
        total += evenDiv
    }
}

END { print total }
