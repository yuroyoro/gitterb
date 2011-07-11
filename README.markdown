Gitterb The Graphical Git Repository Viewer.
===========================================================================

The Graphical Git reporsitory Viewer Made by Ruby on Rails 3.0.9.

## Setup

Gitterb requires pygments. install it if you haven't.

    sudo easy_install pygments

Install dependencies gems using Bundler.

    gem install bundler # if you haven't
    bundle install ./vendor/bundle

copy config/application.rb.sample to config/application.rb

    cp config/application.rb.sample config/application.rb

and edit config/application.rb and specify git reporsitory path(absolute path) .

      REPOSITORY = '/home/your_name/your_repository'

start server and visit 'http://localhsost:3000'

    script/rails server

## Usage and Screen shots

<img src='https://github.com/yuroyoro/gitterb/raw/master/doc/screeen_shots/screen_shot1.png' width='600'/>

The commit-tree of the master branch is displayed first. a round figure shows Commit object.
100 Commits from master's HEAD is displayed,
and Branch/tag that can reach to master's commits displayed is additionally output, too.

to change forcused branch from 'master', select the branch at header's pulldown.
turn off the 'all' checkbox,  then other branch's Commits are hidden.
max-count is maximum number of commits to output.

<img src='https://github.com/yuroyoro/gitterb/raw/master/doc/screeen_shots/screen_shot2.png' width='600'/>

when the mouse over on Commit,  the commit summary is popuped.
and click commit, details shown left or right side. double click on the details area, it's to be hide.

<img src='https://github.com/yuroyoro/gitterb/raw/master/doc/screeen_shots/screen_shot3.png' width='600'/>

## License

Copyright (c) 2011 Tomohito Ozaki(yuroyoro).

Released under the Lesser GNU Public License (LGPL).

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

