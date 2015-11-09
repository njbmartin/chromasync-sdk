# ChromaSync SDK

Chroma Sync is the easiest way to sync games and apps, and create beautiful and reactive lighting effects.

The SDK provides a means of interacting with Chroma Sync in a relatively simple manner either via the simple API or via Lua scripts.

##Main Features

###The Chroma Sync API
Developers can provide built-in support for Chroma Sync thanks to it's simple to use API. Community developers can even create mods/plugins for their favourite apps/games to provide support via the API. Anyone can then customise their own effects via Lua scripts.

###Built-in Lua support
Anyone can customise in-game effects supported by Chroma Sync or even script beautiful lighting effects that would be impossible with Razer's Chroma Configurator.

## So, API or Lua?

In simple terms, the API handles the **input** from other apps/games, whereas Lua consumes it and provides the logic for the lighting effects - or **output**.

It works like so:

1. A Game/Application can send data to Chroma Sync via an API
2. In order for the data to be consumed, a Lua script must register to receive the data
3. Lua script consumes the data and is responsible for the lighting effects

Note that Lua scripts can also work independently, and is perfect for those who want to create totally custom lighting effects/animations.
