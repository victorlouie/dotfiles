{
    "sso-session victor-sso-session" = {
        sso_start_url = "https://a-bcdefg.awsapps.com/start/#";
        sso_region = "us-east-1";
    };

    "profile xyz" = {
        sso_session = "victor-sso-session";
        sso_role_name = "victor-role-name";
        sso_account_id = "012345";
        region = "us-east-1";
        output = "json";
    };
}

