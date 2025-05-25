# Install Pass and Browserpass on Mac

1. Install gpg-suite: `brew install gpg-suite-no-mail`
2. Import GPG key: `gpg --import ~/.ssh/gpg-key`
3. Set GPG suite password timeout to 99999
4. Clone password-store repo
5. Install [Browserpass](https://chromewebstore.google.com/detail/browserpass/naepdomgkenhinolocfifgehidddafch?pli=1) on the browser side
6. Install [native messaging host](https://github.com/browserpass/browserpass-native) on the OS side
7. Use the provided `Makefile` and run:
`PREFIX='/opt/homebrew/opt/browserpass' make hosts-edge-user -f Makefile`
8. Install `pinentry-mac`
