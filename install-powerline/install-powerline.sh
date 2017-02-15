#!/bin/bash


SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get install python-pip

# Install powerline PIP package
pip install --user powerline-status
export PATH="${HOME}/.local/bin/:${PATH}"

# Install additional packages requires by different segments
pip install --user psutil

sudo apt-get install -y python-dev \
        libffi-dev \
        libgit2-dev \
        libgit2-24 \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        libssh2-1
pip install --user pygit2==0.24.2

# Install powerline fonts 
# REMEMBER: The terminal must also either be configured to use patched fonts,
# or support fontconfig for powerline to work properly with powerline-specific
# glyphs.
if [ "$1" == "--install-fonts" ]; then
	font_dir=`mktemp -p ${SCRIPTDIR} -d -t powerline-fonts.XXXXXX`

	git clone https://github.com/powerline/fonts.git ${font_dir}
	${font_dir}/install.sh
fi

# Change default shell theme (include everything on the left side of the prompt)
mkdir -p ~/.config/powerline
cat <<-'EOF' > ~/.config/powerline/config.json
{
    "ext": {
        "shell": {
            "theme": "default_leftonly"
        }
    }
}
EOF

# Install powerline settings to the .bashrc
ln -b -s "${SCRIPTDIR}"/.powerlinerc "${HOME}" 
cat <<- 'EOF' >> ~/.bash_custom

# Enable powerline settings
if [ -f ~/.powerlinerc ]; then
    . ~/.powerlinerc
fi
EOF
