<p align="center">
    <img src="https://user-images.githubusercontent.com/54685446/201329617-9fd91ab0-35c2-42c2-8963-47b68c6a490a.png" alt="DiscordReactToRole">
    <br>
    <a href="https://github.com/DiscordBM/DiscordReactToRole/actions/workflows/tests.yml">
        <img src="https://github.com/DiscordBM/DiscordReactToRole/actions/workflows/tests.yml/badge.svg" alt="Tests Badge">
    </a>
    <a href="https://codecov.io/gh/DiscordBM/DiscordReactToRole">
        <img src="https://codecov.io/gh/DiscordBM/DiscordReactToRole/branch/main/graph/badge.svg?token=P4DYX2FWYT" alt="Codecov">
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/swift-5.8%20/%205.7-brightgreen.svg" alt="Latest/Minimum Swift Version">
    </a>
</p>

<p align="center">
     🌟 Just a reminder that there is a 🌟 button up there if you liked this project 😅 🌟
</p>

## Discord React-To-Role
`DiscordReactToRole` is a utility so your bot can easily assign roles to users who react to a message with pre-defined reactions.    
It uses [DiscordBM](https://github.com/DiscordBM/DiscordBM) to communicate with Discord.

## How To Use
  
> Make sure you have **Xcode 14.1 or above**. Lower Xcode 14 versions have known issues that cause problems for libraries.    

`ReactToRoleHandler` will automatically assign a role to members when they react to a message with specific emojis:

```swift
let handler = try await ReactToRoleHandler(
    gatewayManager: <#GatewayManager You Made In Previous Steps#>,
    /// Your DiscordCache. This is not necessary (you can pass `nil`)
    /// Only helpful if the cache has `guilds` and/or `guildMembers` intents enabled
    cache: cache,
    /// The role-creation payload
    role: .init(
        name: "cool-gang",
        color: .green
    ),
    guildId: <#Guild ID of The Message You Created#>,
    channelId: <#Channel ID of The Message You Created#>,
    messageId: <#Message ID of The Message You Created#>,
    /// The list of reactions to get the role for
    reactions: [.unicodeEmoji("🐔")]
)
```

After this, anyone reacting with `🐔` to the message will be assigned the role.   
There are a bunch more options, take a look at `ReactToRoleHandler` initializers for more info.

> **Warning**   
> The handler will need quite a few permissions. Namely `view messages`, `send messages` & `add reactions` in the channel where the message is, plus `manage roles` in the guild. These are only the minimums. If the bot is receiving 403 responses from Discord, it probably needs some more permissions as well.

#### Behavior
The handler will:
* Verify the message exists at all, and throws an error in the initializer if not.
* React to the message as the bot-user with all the reactions you specified.
* Re-create the role if it's removed or doesn't exist.
* Stop working if you use `await handler.stop()`.
* Re-start working again if you use `try await handler.restart()`.

#### Persistence 
If you need to persist the handler somewhere:
* You only need to persist handler's `configuration`, which is `Codable`.
* You need to update the configuration you saved, whenever it's changed.   
  To become notified of configuration changes, you should use the `onConfigurationChanged` parameter in initializers:

```swift
let handler = try await ReactToRoleHandler(
    .
    .
    .
    onConfigurationChanged: { configuration in 
        await saveToDatabase(configuration: configuration)
    }
)
```

## How To Add DiscordReactToRole To Your Project

To use the `DiscordReactToRole` library in a SwiftPM project, 
add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/DiscordBM/DiscordReactToRole", from: "1.0.0-beta.1"),
```

Include `DiscordReactToRole` as a dependency for your targets:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "DiscordReactToRole", package: "DiscordReactToRole"),
]),
```

Finally, add `import DiscordReactToRole` to your source code.

## Versioning
`DiscordReactToRole` will follow Semantic Versioning 2.0.0.

## Contribution & Support
Any contribution is more than welcome. You can find me in [Vapor's Discord server](https://discord.gg/vapor) to discuss your ideas.    
Passing the tests is not required for PRs because of token/access problems. I'll manually test your PR.
