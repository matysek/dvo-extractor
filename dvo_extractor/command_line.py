# Copyright 2023 Red Hat Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""command_line submodule includes the handlers for CLI commands."""

import argparse
import logging
import sys


def parse_args() -> argparse.Namespace:
    """Parse the command line options and arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("config", nargs="?", help="Application Configuration.")
    parser.add_argument("--version", help="Show version", action="store_true")
    return parser.parse_args()


def print_version() -> None:
    """Log version information."""
    logger = logging.getLogger(__name__)
    logger.info(
        "Python interpreter version: %d.%d.%d",
        sys.version_info.major,
        sys.version_info.minor,
        sys.version_info.micro,
    )


def insights_dvo_extractor() -> None:
    """Handle for dvo-extractor command."""
    args = parse_args()

    if args.version:
        logging.basicConfig(format="%(message)s", level=logging.INFO)
        print_version()
        sys.exit(0)

    sys.exit(1)
