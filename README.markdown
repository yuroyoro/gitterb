Gitterb The Graphical Git Repository Viewer.
===========================================================================

The Graphical Git reporsitory Viewer Made by Ruby on Rails 3.0.9.

## Setup

Gitterb requires pygments. install it if you haven't.

    sudo easy_install pygments

Install dependencies gems using Bundler.

    gem install bundler # if you haven't
    bundle install ./vendor/bundle

Edit config/database.yml and specify git reporsitory path(absolute path) .

    development:
      repository: '/home/your_name/your_repository'

start server and visit 'http://localhsost:3000'

    script/rails server


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

