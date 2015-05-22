## Clinical Trials App

<a href="http://scheduling-app.herokuapp.com/" target="#">Clinical Trial Scheduler</a>

By <a href="https://github.com/alexcaste" target="#">Alex Castaneda</a>, <a href="https://github.com/savage-j" target="#">Jordan Savage</a>, <a href="https://github.com/finalfreq" target="#">James Williams</a>, & <a href="https://github.com/matchbookmac" target="#">Ian MacDonald</a>

@ Epicodus Programming School, Portland, OR

GNU General Public License, version 3 (see below). Copyright (c) 2015.

### Description

**Clinical Trials**

An application to ease the scheduling of patients for clinical trials. Trials with varrying length and visit frequency may be
tracked. The visit scheduler will notify the users of conflicts during scheduling so that visit schedules may be confidently
generated and predicted for months in the future.

### Author(s)

Alex Castaneda, Jordan Savage, James Williams, & Ian MacDonald

### Setup

This app was written in `ruby '2.0.0'`.

Clone this repo with
```console
> git clone https://github.com/alexcaste/clinical_trials.git
```

Install gems:

```console
> bundle install
```

Create database
```console
> rake db:create
> rake db:migrate
> rake db:test:prepare
```

Start App:
```console
> ruby app.rb
```

### Database Schema

TO BE ADDED

### License ###
Copyright  (C)  2015  for the authors listed above

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
