name             'scollector'
maintainer       'ptqa'
maintainer_email 'ptqa.mail@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures scollector'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '4.0.4'

supports 'ubuntu'

depends 'runit'
depends 'golang', '>= 1.5.0'
