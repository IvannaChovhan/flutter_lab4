class Comment {
  final int _id;
  final String _commentText;
  final int _postId;
  final int _userId;

  Comment(this._id, this._commentText, this._postId, this._userId);

  get id => _id;
  get commentText => _commentText;
  get postId => _postId;
  get userId => _userId;
}

// !TODO: change DB biew make assotivative entity for Post and User
