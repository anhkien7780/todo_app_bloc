enum Environment { dev, stg, prod }

extension EnvironmentExt on Environment{
  String get envName{
    switch(this){
      case Environment.dev:
        return "LOCAL";
      case Environment.stg:
        return "STAGING";
      case Environment.prod:
        return "PROD";
    }
  }

  String get baseUrl {
    switch(this){
      case Environment.dev:
        return "https://raffpmryzsjtrgifysgv.supabase.co";
      case Environment.stg:
        return "https://raffpmryzsjtrgifysgv.supabase.co";
      case Environment.prod:
        return "https://raffpmryzsjtrgifysgv.supabase.co";
    }
  }

  String get redirectUrl {
    switch(this){
      case Environment.dev:
        return "todoapp://login-callback/";
      case Environment.stg:
        return "todoapp://login-callback/";
      case Environment.prod:
        return "todoapp://login-callback/";
    }
  }
}
