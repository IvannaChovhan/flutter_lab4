import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:my_instagram/models/feed.dart';
import 'package:my_instagram/models/user_model.dart';

List<User> usersFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

User userFromJson(String jsonData) {
  return User.fromJson(json.decode(jsonData)[0]);
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

abstract class MetaApi {
  final String baseUrl = "http://127.0.0.1:5000";
  Client client = Client();
}

class ApiUserService extends MetaApi {
  ApiUserService._privateConstructor();

  static final ApiUserService _instance = ApiUserService._privateConstructor();

  static ApiUserService get instance => _instance;

  Future<List<User>> getUsers() async {
    final response = await client.get(Uri.parse("$baseUrl/api/users/"));
    if (response.statusCode == 200) {
      return usersFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<User> getUser(int id) async {
    final response = await client.get(Uri.parse("$baseUrl/api/users/$id/"));
    print(response.statusCode);
    print(response.body);
    print("response.body");
    if (response.statusCode == 200) {
      print(userFromJson(response.body));
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<User>> getFriends(int id) async {
    final response =
        await client.get(Uri.parse("$baseUrl/api/users/$id/friends"));
    if (response.statusCode == 200) {
      print(usersFromJson(response.body));
      return usersFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createUser(User data) async {
    final response = await client.post(
      Uri.parse("$baseUrl/api/users/"),
      headers: {"content-type": "application/json"},
      body: userToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(User data) async {
    final response = await client.put(
      Uri.parse("$baseUrl/api/users/${data.id}"),
      headers: {"content-type": "application/json"},
      body: userToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/api/profile/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

FeedModel feedFromJson(String jsonData) =>
    FeedModel.fromJson(json.decode(jsonData)[0]);

class APIFeedService extends MetaApi {
  Future<FeedModel> getFeedByUserId(int id) async {
    final response = await client.get(Uri.parse("$baseUrl/api/feeds/$id/"));
    if (response.statusCode == 200) {
      print(feedFromJson(response.body));
      print("feedFromJson(response.body)");
      return feedFromJson(response.body);
    } else {
      return null;
    }
  }
}
