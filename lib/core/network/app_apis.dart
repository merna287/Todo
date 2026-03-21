class AppApis {

  static const String baseUrl = "todo-backends-704q.onrender.com";
  static const String register = "/api/auth/register";
  static const String login = "/api/auth/login";
  static const String getProfile = "/api/auth/me";

  static const String getTodos = "/api/todos";
  static const String createTodo = "/api/todos";
  static String getTodoById(String id) => "/api/todos/$id";
  static String updateTodo(String id) => "/api/todos/$id";
  static String deleteTodo(String id) => "/api/todos/$id";

}