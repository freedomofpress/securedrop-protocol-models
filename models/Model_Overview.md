## v1

### `source_journalist.spthy`

Simple interaction between source and journalist. A source gets the journalist's keys and sends a submission.
Only the intended journalist can view the plaintext of the message.

Message fetching is omitted.

## v2

### `source_journalist_response.spthy`

This model extends `v1/source_journalist.spthy` with a response of the journalist. The response is linked to the previous message. Only the sender of the previous message can read the response.

## v3

### `source_journalist_fetching.spthy`

This model extends `v2/source_journalist_fetching.spthy` with the message fetching process on the journalist's side (i.e., source doesn't fetch the journalist's reply). Instead of modelling the server, the source and journalist send the fetching messages into the network. Even under these circumstances, there should be a traces where the protocol finishes (namely when the adversary IS the server).

Both executability lemmas - `Executability_Small` and `Executability` - can't be proven.

## v4

### `source_journalist_fetching.spthy`

In this model, I investigated the fact that even by just outputting $mgdh$, Tamarin doesn't find a single trace for the protocol.

It seems that with [this fix](https://github.com/lumaier/securedrop-formalanalysis/commit/febf1527359b9dd42842f48c70e7758dc2cd1521) we can solve the problem: don't output triples (or even tuples?).