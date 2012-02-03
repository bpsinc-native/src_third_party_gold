#!/bin/sh
# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Wrapper script named "ld" that either executes gold or the system linker.

# The gold binary was built on 64-bit Ubuntu Lucid.  Don't run it on
# non-64-bit machines.  Note that "uname -m" prints the kernel architecture,
# while this binary will also fail on 64-bit kernels with 32-bit userlands.

base_dir=$(dirname "$0")
machine=$(gcc -dumpmachine)
if [ "$machine" = "x86_64-linux-gnu" ]; then
    exec $base_dir/gold64 "$@"
else
    # Fall back on the ld found in $PATH.
    exec ld "$@"
fi
