# Docker Cordova

Docker cordova image.

### How to use

Define your own Dockerfile based on this image.

```shell
FROM yassinekhachlek/docker-cordova

RUN mkdir -p /var/cordova

WORKDIR /var/cordova

VOLUME ["/var/cordova"]
```

Some shell scripts are provided to create, add android platform, and build the application.

First put scripts in the same Dockerfile directory then all you have to do is to call them from any where like below:


```shell
# Create a new application
./docker-project/create.sh app-name

# Add the android platform
./docker-project/add_anroid.sh app-name

# Build the android apk
./docker-project/build_anroid.sh app-name
```

## License

### GPLv2

Copyright (c) 2016 Yassine Khachlek <yassine.khachlek@gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.