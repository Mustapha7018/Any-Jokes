import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    bool error;
    String category;
    String type;
    String setup;
    String delivery;
    Flags flags;
    int id;
    bool safe;
    String lang;

    Welcome({
        required this.error,
        required this.category,
        required this.type,
        required this.setup,
        required this.delivery,
        required this.flags,
        required this.id,
        required this.safe,
        required this.lang,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        error: json["error"],
        category: json["category"],
        type: json["type"],
        setup: json["setup"],
        delivery: json["delivery"],
        flags: Flags.fromJson(json["flags"]),
        id: json["id"],
        safe: json["safe"],
        lang: json["lang"],
    );

  get joke => 'No such joke';

    Map<String, dynamic> toJson() => {
        "error": error,
        "category": category,
        "type": type,
        "setup": setup,
        "delivery": delivery,
        "flags": flags.toJson(),
        "id": id,
        "safe": safe,
        "lang": lang,
    };
}

class Flags {
    bool nsfw;
    bool religious;
    bool political;
    bool racist;
    bool sexist;
    bool explicit;

    Flags({
        required this.nsfw,
        required this.religious,
        required this.political,
        required this.racist,
        required this.sexist,
        required this.explicit,
    });

    factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        nsfw: json["nsfw"],
        religious: json["religious"],
        political: json["political"],
        racist: json["racist"],
        sexist: json["sexist"],
        explicit: json["explicit"],
    );

    Map<String, dynamic> toJson() => {
        "nsfw": nsfw,
        "religious": religious,
        "political": political,
        "racist": racist,
        "sexist": sexist,
        "explicit": explicit,
    };
}
