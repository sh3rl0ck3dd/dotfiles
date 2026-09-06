# NixOS on Windows 11 — Complete Fresh Installation Guide

This guide installs **NixOS inside Windows 11 using WSL 2**.

It is written for a fresh installation and explains both **what to type** and **what each command does**.

---

## 1. What are we installing?

The final setup looks like this:

```text
Windows 11
    │
    └── WSL 2
          │
          └── NixOS
                │
                ├── Nix package manager
                ├── NixOS configuration
                └── Linux development environment
```

### What is WSL?

**WSL = Windows Subsystem for Linux.**

WSL allows Linux distributions to run inside Windows without traditional dual boot.

We will use **WSL 2**.

### What is NixOS?

NixOS is a Linux distribution built around the **Nix package manager** and declarative system configuration.

Instead of manually configuring the system, you can describe the desired state in Nix files and let NixOS build it.

---

# 2. Requirements

You need:

- Windows 11
- Hardware virtualization enabled
- Internet connection
- Administrator access to Windows
- Enough disk space

---

# 3. Check whether WSL is already installed

Open **PowerShell**.

Run:

```powershell
wsl --version
```

Then:

```powershell
wsl --status
```

And:

```powershell
wsl -l -v
```

### What do these commands do?

`wsl --version`

Shows the installed WSL version.

`wsl --status`

Shows the current WSL configuration.

`wsl -l -v`

Lists installed Linux distributions and whether they use WSL 1 or WSL 2.

---

# 4. Install WSL if necessary

If WSL is not installed, open **PowerShell as Administrator** and run:

```powershell
wsl --install --no-distribution
```

### Why `--no-distribution`?

Normally:

```powershell
wsl --install
```

installs WSL and a default Linux distribution, usually Ubuntu.

We do not need Ubuntu because we are going to install NixOS ourselves.

Therefore:

```powershell
wsl --install --no-distribution
```

means:

> Install the WSL infrastructure, but don't install a default Linux distribution.

Restart Windows if Windows asks you to.

After restarting, verify:

```powershell
wsl --version
```

---

# 5. Download NixOS-WSL

Download the latest NixOS-WSL release from:

https://github.com/nix-community/NixOS-WSL/releases/latest

For a normal Intel/AMD Windows PC, use:

```text
nixos.wsl
```

For an ARM64 Windows computer, use:

```text
nixos.aarch64.wsl
```

### Which one should most PCs use?

Most Intel and AMD Windows 11 PCs use:

```text
nixos.wsl
```

Only use:

```text
nixos.aarch64.wsl
```

if your Windows machine is ARM64.

---

# 6. Install NixOS

Assume the downloaded file is:

```text
C:\Users\<USERNAME>\Downloads\nixos.wsl
```

Open PowerShell and run:

```powershell
wsl --install --from-file C:\Users\<USERNAME>\Downloads\nixos.wsl
```

Replace `<USERNAME>` with your Windows username.

For example:

```powershell
wsl --install --from-file C:\Users\Rajat\Downloads\nixos.wsl
```

### What does this command mean?

```text
wsl
```

Use the WSL command-line interface.

```text
--install
```

Install a WSL distribution.

```text
--from-file
```

Install the distribution from a `.wsl` image file.

```text
nixos.wsl
```

The NixOS-WSL image.

---

# 7. Start NixOS

From PowerShell:

```powershell
wsl -d NixOS
```

`-d` means `--distribution`.

So:

```powershell
wsl -d NixOS
```

means:

> Start the WSL distribution named NixOS.

You can also launch NixOS from Windows Terminal or the Start menu.

---

# 8. Verify that you are inside NixOS

Once the NixOS shell opens, run:

```bash
pwd
```

Expected result:

```text
/home/nixos
```

Check the current user:

```bash
whoami
```

Expected result:

```text
nixos
```

Check the Linux kernel:

```bash
uname -a
```

Check the Nix version:

```bash
nix --version
```

Check the NixOS version:

```bash
nixos-version
```

---

# 9. Set a password

Set a password for the `nixos` user:

```bash
passwd
```

You will be asked:

```text
New password:
Retype new password:
```

### Why do we need this?

The password is needed when using `sudo`.

---

# 10. Understand sudo

`sudo` means:

> Run a command with elevated/root privileges.

For example:

```bash
sudo nix-channel --update
```

The command is composed of:

```text
sudo
```

Run the command as root.

```text
nix-channel
```

Nix's channel-management command.

```text
--update
```

Update the channel information.

So:

```bash
sudo nix-channel --update
```

means:

> As root, update the Nix channel information.

---

# 11. Update Nix channels

Run:

```bash
sudo nix-channel --update
```

This downloads/refreshes the channel information used by the initial NixOS setup.

This is different from updating Windows.

---

# 12. Verify Nix

Run:

```bash
nix --version
```

You should see something similar to:

```text
nix (Nix) 2.x.x
```

Also run:

```bash
nixos-version
```

This shows the installed NixOS version.

---

# 13. Make NixOS the default WSL distribution

Exit NixOS:

```bash
exit
```

You should now be back in PowerShell.

Run:

```powershell
wsl -s NixOS
```

This sets NixOS as the default WSL distribution.

After that, this:

```powershell
wsl
```

will open NixOS automatically.

Instead of needing:

```powershell
wsl -d NixOS
```

every time.

---

# 14. Verify WSL

From PowerShell:

```powershell
wsl -l -v
```

You should see something similar to:

```text
  NAME      STATE           VERSION
* NixOS     Running         2
```

The `*` means NixOS is the default WSL distribution.

The `2` means it is running under WSL 2.

---

# 15. Windows filesystem vs Linux filesystem

Inside NixOS, Windows drives are normally available under:

```text
/mnt/
```

For example:

```bash
ls /mnt/c
```

is essentially looking at:

```text
C:\
```

Therefore:

```text
Windows:
C:\Users\Rajat

NixOS:
/mnt/c/Users/Rajat
```

This is an important WSL concept.

---

# 16. Linux home directory

Your Linux home directory is:

```text
/home/nixos
```

Go there with:

```bash
cd ~
```

or simply:

```bash
cd
```

Check it:

```bash
pwd
```

---

# 17. Basic Linux commands

## List files

```bash
ls
```

Detailed listing:

```bash
ls -la
```

## Change directory

```bash
cd directory
```

## Go home

```bash
cd ~
```

## Go up one directory

```bash
cd ..
```

## Show current directory

```bash
pwd
```

## Create a directory

```bash
mkdir my-folder
```

## Create nested directories

```bash
mkdir -p ~/projects/my-project
```

## Remove a file

```bash
rm filename
```

## Remove a directory

```bash
rm -r directory
```

Be careful with `rm`. It does not normally use the Windows Recycle Bin.

---

# 18. NixOS configuration

The main NixOS configuration is normally under:

```text
/etc/nixos/
```

Check it:

```bash
sudo ls -la /etc/nixos
```

You may see files such as:

```text
configuration.nix
hardware-configuration.nix
```

The exact files can vary depending on the NixOS-WSL release.

---

# 19. What is configuration.nix?

`configuration.nix` describes how your NixOS system should be configured.

For example:

```nix
{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];
}
```

This declares that Git, curl, and wget should be installed as system packages.

Instead of manually installing and configuring everything, NixOS uses the configuration to build the desired system.

---

# 20. What is nixos-rebuild?

After modifying the NixOS configuration, use:

```bash
sudo nixos-rebuild switch
```

This means:

> Evaluate the NixOS configuration, build the required system, and activate it.

The basic flow is:

```text
configuration.nix
        │
        ▼
   Nix evaluates it
        │
        ▼
Packages and configuration are built
        │
        ▼
A new system generation is created
        │
        ▼
The new generation becomes active
```

---

# 21. Test a configuration

Before permanently switching to a configuration, you can use:

```bash
sudo nixos-rebuild test
```

This activates the configuration temporarily.

After rebooting, the previous generation will normally be used again.

For normal permanent activation:

```bash
sudo nixos-rebuild switch
```

---

# 22. NixOS generations

NixOS keeps previous system configurations as **generations**.

This makes rollback possible.

You can list system generations with:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

This is one of the major advantages of NixOS.

If a configuration change breaks something, you can roll back instead of manually undoing every change.

---

# 23. Nix flakes

For a new setup, it is recommended to learn the modern **flake-based** workflow.

A typical flake contains:

```text
flake.nix
flake.lock
```

### flake.nix

Defines your configuration and its dependencies.

### flake.lock

Pins exact versions/revisions of those dependencies.

This makes the environment much more reproducible.

A typical structure might eventually look like:

```text
~/nixos/
│
├── flake.nix
├── flake.lock
│
├── hosts/
│   └── nixos-wsl/
│       └── configuration.nix
│
├── modules/
│   ├── packages.nix
│   ├── git.nix
│   └── shell.nix
│
└── home/
```

---

# 24. Enable flakes

For commands requiring flakes, enable the experimental features:

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

This enables:

```text
nix-command
flakes
```

Verify:

```bash
nix flake --help
```

If that works, the flake interface is available.

### Important

The `export` command only applies to the current shell session.

For a permanent setup, configure this through NixOS rather than relying on a temporary `export`.

---

# 25. Flake workflow

Once you have a flake-based NixOS configuration:

```bash
cd ~/nixos
```

Update flake inputs:

```bash
nix flake update
```

Build and activate the configuration:

```bash
sudo nixos-rebuild switch --flake .
```

The `.` means:

> Use the flake in the current directory.

---

# 26. Git

Git is strongly recommended for storing your NixOS configuration.

Check whether Git is installed:

```bash
git --version
```

A temporary way to get Git is:

```bash
nix-shell -p git
```

For a permanent setup, add Git to your NixOS configuration.

---

# 27. Why use Git for NixOS?

Your Nix configuration can become the definition of your entire environment.

Git allows you to track changes:

```text
Nix configuration
       │
       ▼
     Git
       │
       ├── commit 1
       ├── commit 2
       ├── commit 3
       └── ...
```

If you break something, you can inspect or revert the configuration.

You can also store the configuration on a remote Git server.

---

# 28. Updating Nix

There are two different workflows.

## Legacy channel workflow

```bash
sudo nix-channel --update
```

## Flake workflow

```bash
nix flake update
```

These are not the same command.

Once you have moved your system to flakes, your normal workflow will generally revolve around:

```bash
nix flake update
```

and:

```bash
sudo nixos-rebuild switch --flake .
```

---

# 29. Garbage collection

Nix keeps old packages and generations so that they can be reused or rolled back.

You can eventually remove old generations with:

```bash
sudo nix-collect-garbage --delete-old
```

### Important

Do not run this blindly while you are learning Nix.

Old generations are useful while experimenting because they provide rollback points.

---

# 30. Useful WSL commands

These commands are run from **PowerShell**, not inside NixOS.

## Start NixOS

```powershell
wsl -d NixOS
```

## Start the default distribution

```powershell
wsl
```

## List distributions

```powershell
wsl -l -v
```

## Set NixOS as default

```powershell
wsl -s NixOS
```

## Stop NixOS

```powershell
wsl --terminate NixOS
```

## Shut down all WSL distributions

```powershell
wsl --shutdown
```

---

# 31. PowerShell vs NixOS commands

This distinction is important.

## Commands run in Windows PowerShell

```powershell
wsl -l -v
wsl --shutdown
wsl -d NixOS
wsl -s NixOS
```

## Commands run inside NixOS

```bash
ls
cd
pwd
sudo
nix
nixos-rebuild
nixos-version
```

If a command starts with:

```text
wsl
```

it is generally a Windows/WSL management command.

If it starts with:

```text
nix
```

or:

```text
nixos
```

it is generally being run inside NixOS.

---

# 32. Fresh-install checklist

Use this checklist when setting up a new Windows 11 machine.

```text
[ ] Windows 11 installed and updated
[ ] Hardware virtualization enabled
[ ] WSL installed
[ ] WSL 2 working
[ ] NixOS-WSL image downloaded
[ ] Correct architecture selected
[ ] NixOS imported into WSL
[ ] NixOS starts successfully
[ ] nixos user password configured
[ ] Nix version verified
[ ] NixOS version verified
[ ] Nix channels initially updated
[ ] NixOS set as default WSL distribution
[ ] WSL version verified as 2
[ ] /etc/nixos inspected
[ ] configuration.nix understood
[ ] Flakes enabled
[ ] Git installed
[ ] NixOS configuration placed under Git
[ ] Flake-based configuration created
[ ] First successful nixos-rebuild completed
```

---

# 33. Recommended final architecture

The goal should eventually be:

```text
Windows 11
│
└── WSL 2
    │
    └── NixOS
        │
        ├── ~/nixos/
        │   │
        │   ├── flake.nix
        │   ├── flake.lock
        │   │
        │   ├── hosts/
        │   │   └── nixos-wsl/
        │   │       └── configuration.nix
        │   │
        │   ├── modules/
        │   │   ├── packages.nix
        │   │   ├── git.nix
        │   │   └── shell.nix
        │   │
        │   └── home/
        │
        └── Git repository
```

This gives you a reproducible Linux development environment.

---

# 34. Quick reference

## Windows / PowerShell

```powershell
wsl --version
wsl --status
wsl -l -v
wsl --install --no-distribution
wsl --install --from-file C:\path\to\nixos.wsl
wsl -d NixOS
wsl -s NixOS
wsl --terminate NixOS
wsl --shutdown
```

## NixOS / Linux

```bash
pwd
whoami
uname -a
nix --version
nixos-version
passwd
sudo nix-channel --update
sudo ls -la /etc/nixos
sudo nixos-rebuild test
sudo nixos-rebuild switch
nix flake --help
nix flake update
sudo nixos-rebuild switch --flake .
git --version
```

---

# 35. Official documentation

NixOS-WSL:

https://github.com/nix-community/NixOS-WSL

NixOS-WSL releases:

https://github.com/nix-community/NixOS-WSL/releases

NixOS documentation:

https://nixos.org/learn/

Nix documentation:

https://nix.dev/

---

# 36. Important principle

Do not try to memorize all of these commands.

The important concepts are:

```text
WSL
 │
 ├── manages Linux distributions from Windows
 │
 └── NixOS
      │
      ├── manages the Linux system
      │
      └── Nix
           │
           ├── manages packages
           └── manages reproducible configurations
```

And the core NixOS workflow is:

```text
Edit configuration
       │
       ▼
nixos-rebuild
       │
       ▼
New generation
       │
       ▼
Active system
```

For a modern setup, the longer-term workflow is:

```text
flake.nix + flake.lock
          │
          ▼
         Git
          │
          ▼
nixos-rebuild switch --flake .
```

That is the foundation for a reproducible NixOS development environment.
