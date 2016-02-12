# path utility

Tool to configure the \$PATH environment variable.
This is handy when dealing with heterogenous project
environments, all coming with different collections
of binaries, or at least the same binaries in but
in several different versions.

# Motivation

If you want to get all locally installed binaries coming
out of an npm install, just create a file in the project
root called PATH and add the local path to the binaries
you need on the path in order to work with the project.

```bash
echo 'node_module/.bin' >> PATH
```

Then call

```bash
path config show
```

which will append all configurations and show the resulting $PATH.
In this case there is only one additional configuration
in the PATH file, which will be appended onto the $PATH
environment variable. 

Afterwards you should be able to run all the node modules
being installed locally as if they were installed globally.
This is good way to keep the system clean from project
specific dependencies, but without inconveniences.

To see the help and with it all available commands type:
```bash
path
path help
```

# Development

ATM this is a very early stage, everything might change
by now and some things probably will change. Feel free
to file a pull request or to contact me on any behalf.

# Usage

```bash
path <cmd1> [... <cmdN>]
```

Performs a series of path commands in given order

# Commands

Here is a list of currently available commands:

| Command       |     | Description                                                    |
| ------------- | --- | -------------------------------------------------------------- |
| `help       ` |     | Shows this help                                                |
| `save       ` | M   | Saves current path into backup-file                            |
| `load       ` | M   | Loads path from save-file file created with load               |
| `reset      ` | M   | Loads path from backup-file file created at shell spawn        |
| `config     ` | M   | Appends configuration from config-file to PATH                 |
| `echo-on    ` |     | Enable echo for upper mutator commands                         |
| `echo-off   ` |     | Disable echo for upper mutator commands                        |
| `show       ` |     | Shows contents of the PATH environment variable                |
| `show-saved ` |     | Shows contents of backup-file                                  |
| `show-config` |     | Shows built path using config-file                             |

Commands planned for the future:
- [ ] add .bin from npm
- [ ] add all bin subfolders from bower
- [ ] add all bin subfolders from composer

# Examples

| Command               | Description                                        |
| --------------------- | -------------------------------------------------- |
| `path save show-bak ` | Save current \$PATH and show backup-file           |
| `path show-config   ` | Show built \$PATH using the config-file            |
| `path config show   ` | Configure \$PATH from config-file and show it      |
| `path echo-on reset ` | Enable echo and reset \$PATH from backup-file      |


# Installation

To install this tool you can put the path.sh file
into somewhere accessible location e.g. ~/path.sh.

```bash
wget .../path.sh ~

```
Then there are two options to install the tool:
Manual vs automatic loading. With manual loading
it is performed explicitly on demand, automatic 
is performed on every shell incarnation.

Maybe in the future there will be three
configurable modes like:
 - Manual 
 - Shell (semi-automatic)
 - Interactive (automatic)

## Manual Loading

```bash
source ~/path.sh && path backup
```

This will just source the file on demand expose
the `path` function during the shell session.
Furthermore, it will create a backup of the $PATH
variable.

## Automatic Loading

```bash
echo 'source ~/path.sh && path backup' >> ~/.bashrc
```

The automatic installation command just takes the
manual installation command and appends it to the
current ~/.bashrc file and should only performed
once.

This will make the `path` utility available to
all subsequent shell sessions for this user, and
will always create a fresh backup on startup.
