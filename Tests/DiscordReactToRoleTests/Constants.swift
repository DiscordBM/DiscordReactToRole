import Foundation
import DiscordModels

enum Constants {
    static let token: String = {
        if let token = ProcessInfo.processInfo.environment["BOT_TOKEN"] {
            return token
        } else {
            fatalError("Due to the complexity of making integration tests work, they can only be run by the author of DiscordBM, PRs of the author on Github, or on the main branch commits, at least for now. Please reach out if you are facing any issues because of this")
        }
    }()

    static let guildId: GuildSnowflake = "1036881950696288277"
    static let guildName = "DiscordBM Test Server"

    static let botId: UserSnowflake = "1030118727418646629"

    enum Channels: ChannelSnowflake {
        case reaction = "1073282726750330889"

        var id: ChannelSnowflake {
            self.rawValue
        }
    }
}
