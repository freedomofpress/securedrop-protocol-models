# Actors

## Freedom of Press Foundation

- The Freedom of Press Foundation (FPF) is responsible for maintainig and developing the SecureDrop protocol. 
- The project is open-source and its components are signed with a self-signed signing key controlled by the FPF.
- Even tough FPF can serve as a root of trust by enrolling newsrooms and sign their public keys, SecureDrop is completely usable without the involvement of FPF. In that case, the newsroom holds self-signed public keys and serves as the root of trust (i.e., any actor in the system needs to trust the newsroom).
- For newsrooms holding public keys signed by the FPF's signature-key, FPF maintains a list of .onion addresses pointing to their SecureDrop instances.

## Newsroom

- Entity with formal ownership of a SecureDrop instance.
- Known public entity
- Expected to publish information on how to reach their instance via verified channels (e.g., Webpage using the Web's PKI)
- Responsible for the enrollment of journalists.

## Journalist

- Designated recipient of sensitive information sent by anonymous sources to a newsroom. Can receive and reply to messages.
- Are not anonymous.
- Access the SecureDrop instance over a secure, dedicated client.

## Source

- Wants to share sensitive information while remaining their anonimity.
- Wants to send arbitrary messages and/or files.
- Its safety depends on their anonimity: the higher the degree of plausible deniabililty, the better. No forensic evidence can be left on the source's device. Communication has to be possible with only a memorizable passphrase. 
- To keep anonimity, the source uses Tor to connect to the SecureDrop instance.
