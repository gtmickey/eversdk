use ton_client::{create_context, request_sync};


pub fn ton_request(context: u32, function_name: String, function_params_json: String) -> String {
    return request_sync(context, function_name, function_params_json);
}

pub fn ton_create_context(config: String) -> String {
    return create_context(config);
}