#
# This file is part of AtomVM.
#
# Copyright 2021 Fred Dushin <fred@dushin.net>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0 OR LGPL-2.1-or-later
#

find_program(DOXYGEN_PATH doxygen)

if (DOXYGEN_PATH)
    set(DOXYGEN_FOUND TRUE)
    set(DOXYGEN_BUILD_EXECUTABLE "${DOXYGEN_PATH}")
elseif(DOXYGEN_FIND_REQUIRED)
    message(FATAL_ERROR "Doxygen command (doxygen) not found")
endif()
