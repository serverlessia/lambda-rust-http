use lambda_http::{run, service_fn, Body, Error, Request, Response};
use serde_json::json;

async fn function_handler(_request: Request) -> Result<Response<Body>, Error> {
    let response_body = json!({
        "message": "Hello, world!"
    });

    Ok(Response::builder()
        .status(200)
        .header("content-type", "application/json")
        .body(Body::from(response_body.to_string()))
        .unwrap())
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::INFO)
        .with_target(false)
        .without_time()
        .init();

    run(service_fn(function_handler)).await
}
