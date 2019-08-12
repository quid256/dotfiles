## Dotfiles

This is the repository I used to save my config files for unix-based systems. It also includes an installation script that will add the necessary dependencies if they aren't found and deal with backing up old file versions, etc.

These dotfiles are versioned and managed with git, and are actually stored entirely in the git repository. The install script will create symbolic links from the home directory to the repository so that versioning, and conflict resolution can be dealt with easily.

#### Installation

To install, simply run the following commands (I usually run them in my home directory):

```
$ git clone https://github.com/quid256/dotfiles.git
$ cd dotfiles
$ ./install.sh backup
```

This will backup existing dotfiles that exist in the home directory and replace them with symlinks to the repository. 
