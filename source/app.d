import std.stdio;

import dcord.core;
import dcord.util.process;
import dcord.util.emitter;

import twitchapid;

import vibe.core.core;

void main() {

	string getTokenFromFile(string path) {
    	import std.stdio : File;
    	auto file = File(path, "r");
		return file.rawRead(new char[file.size]).idup;
	}

	immutable token = getTokenFromFile("./token.txt");

	BotConfig config = {
		token     : token,
		cmdPrefix : "",
	};

	Bot bot = new Bot(config, LogLevel.trace);
	bot.loadPlugin(new MyPlugin);
	bot.run;
	runEventLoop;

}


class MyPlugin : Plugin {
	@Listener!(MessageCreate, EmitterOrder.AFTER) 
	void onMessageCreate(MessageCreate event) {
		this.log.info("MessageCreate: ", event.message.content);
	}

	@Command("ping")
	void ping(CommandEvent event) {
		import std.format : format;
		event.msg.reply("Fucking pong: %s".format(event.msg.author));
	}
}

