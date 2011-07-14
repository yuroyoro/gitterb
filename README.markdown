Gitterb The Graphical Git Repository Viewer.
===========================================================================

The Graphical Git reporsitory Viewer Made by Ruby on Rails 3.1.0.rc4

## Setup

Install dependencies gems using Bundler.

    gem install bundler # if you haven't
    bundle install ./vendor/bundle

copy config/iniproperties/repositories.rb.sample to config/initializers/repositories.rb

    cp config/initializers/repositories.rb.sample config/initializers/repositories.rb

and edit config/initializers/repositories.rb and specify git reporsitory path(absolute path) .

    # pass to reporsitory path(absolute path).
    Gitterb::Application.add_repository( '/path/to/repository1')

    # pass to repositoy pass and some options(name, issue trackers url and revisions url...).
    Gitterb::Application.add_repository( '/path/to/repository2',
      :name => 'repo_name2',
      :ticket_url => 'http://redmine.example.com/issues/%s',
      :rev_url => 'http://redmine.example.com/projects/someproject/repository/revisions/%s'
    )

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

