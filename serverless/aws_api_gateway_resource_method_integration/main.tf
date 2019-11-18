resource "aws_api_gateway_model" "alert" {
  rest_api_id  = "${var.rest_api_id}"
  name         = "alert"
  content_type = "application/json"
  schema       = "${var.alert_json_schema}"
}

resource "aws_api_gateway_model" "ArrayOfalert" {
  rest_api_id  = "${var.rest_api_id}"
  name         = "ArrayOfalert"
  content_type = "application/json"
  schema       = "${var.ArrayOfalert_json_schema}"
  depends_on   = ["aws_api_gateway_model.alert"]
}

resource "aws_api_gateway_model" "ApiResponse" {
  rest_api_id  = "${var.rest_api_id}"
  name         = "ApiResponse"
  content_type = "application/json"
  schema       = "${var.ApiResponse_json_schema}"
}

resource "aws_api_gateway_resource" "fetchalerts_resource" {
  rest_api_id = "${var.rest_api_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "fetchalerts"
}

resource "aws_api_gateway_resource" "fetchfilters_resource" {
  rest_api_id = "${var.rest_api_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "fetchfilters"
}

resource "aws_api_gateway_resource" "updatealerts_resource" {
  rest_api_id = "${var.rest_api_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "updatealerts"
}

resource "aws_api_gateway_resource" "updatestoredevicelist_resource" {
  rest_api_id = "${var.rest_api_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "updatestoredevicelist"
}

resource "aws_api_gateway_method" "fetchalerts_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${aws_api_gateway_resource.fetchalerts_resource.id}"
  http_method   = "GET"
  authorization = "AWS_IAM"

  request_parameters = {
    "method.request.querystring.storecode" = true
    "method.request.querystring.viewtype"  = true
  }

  depends_on = [
    "aws_api_gateway_resource.fetchalerts_resource",
  ]
}

resource "aws_api_gateway_method" "fetchfilters_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${aws_api_gateway_resource.fetchfilters_resource.id}"
  http_method   = "GET"
  authorization = "AWS_IAM"

  request_parameters = {
    "method.request.querystring.storecode" = false
  }

  depends_on = [
    "aws_api_gateway_resource.fetchfilters_resource",
  ]
}

resource "aws_api_gateway_method" "updatealerts_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${aws_api_gateway_resource.updatealerts_resource.id}"
  http_method   = "ANY"
  authorization = "AWS_IAM"

  request_parameters = {
    "method.request.querystring.alertId"       = false
    "method.request.querystring.replen_qty"    = false
    "method.request.querystring.replen_status" = false
    "method.request.querystring.replen_time"   = false
  }

  depends_on = [
    "aws_api_gateway_resource.updatealerts_resource",
  ]
}

resource "aws_api_gateway_method" "updatestoredevicelist_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${aws_api_gateway_resource.updatestoredevicelist_resource.id}"
  http_method   = "ANY"
  authorization = "AWS_IAM"

  request_parameters = {
    "method.request.querystring.device_token" = false
    "method.request.querystring.storecode"    = false
  }

  depends_on = [
    "aws_api_gateway_resource.updatestoredevicelist_resource",
  ]
}

resource "aws_api_gateway_integration" "fetchalerts_integration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${aws_api_gateway_resource.fetchalerts_resource.id}"
  http_method             = "${aws_api_gateway_method.fetchalerts_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "${var.lambda_get_alerts_arn}"

  request_templates = {
    "application/json" = <<EOF
{
  "storecode": "$input.params('storecode')",
  "viewtype": "$input.params('viewtype')"
}
EOF
  }

  depends_on = [
    "aws_api_gateway_method.fetchalerts_method",
  ]

  provisioner "local-exec" {
    command = "sleep 30"
  }
}

resource "aws_api_gateway_integration" "fetchfilters_integration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${aws_api_gateway_resource.fetchfilters_resource.id}"
  http_method             = "${aws_api_gateway_method.fetchfilters_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "${var.lambda_get_filters_arn}"

  request_templates = {
    "application/json" = <<EOF
{
  "storecode": "$input.params('storecode')"
}
EOF
  }

  depends_on = [
    "aws_api_gateway_method.fetchfilters_method",
  ]
}

resource "aws_api_gateway_integration" "updatealerts_integration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${aws_api_gateway_resource.updatealerts_resource.id}"
  http_method             = "${aws_api_gateway_method.updatealerts_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "${var.update-replen-alerts_arn}"

  request_templates = {
    "application/json" = <<EOF
{
"alertId":       "$input.params('alertId')",
"replen_qty":    "$input.params('replen_qty')",
"replen_status": "$input.params('replen_status')",
"replen_time":   "$input.params('replen_time')"
}
EOF
  }

  depends_on = [
    "aws_api_gateway_method.updatealerts_method",
  ]
}

resource "aws_api_gateway_integration" "updatestoredevicelist_integration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${aws_api_gateway_resource.updatestoredevicelist_resource.id}"
  http_method             = "${aws_api_gateway_method.updatestoredevicelist_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "${var.lambda_update_store_device_list_arn}"

  request_templates = {
    "application/json" = <<EOF
{
"storecode":       "$input.params('storecode')",
"device_token":    "$input.params('device_token')"
}
EOF
  }

  depends_on = [
    "aws_api_gateway_method.updatestoredevicelist_method",
  ]
}

resource "aws_api_gateway_method_response" "fetchalerts_MethodResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.fetchalerts_resource.id}"
  http_method = "${aws_api_gateway_method.fetchalerts_method.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "ArrayOfalert"
  }

  depends_on = [
    "aws_api_gateway_integration.fetchalerts_integration",
    "aws_api_gateway_model.ArrayOfalert",
  ]
}

resource "aws_api_gateway_method_response" "fetchalerts_MethodResponse_400" {
  rest_api_id     = "${var.rest_api_id}"
  resource_id     = "${aws_api_gateway_resource.fetchalerts_resource.id}"
  http_method     = "${aws_api_gateway_method.fetchalerts_method.http_method}"
  status_code     = "400"
  response_models = {}

  depends_on = [
    "aws_api_gateway_integration.fetchalerts_integration",
  ]
}

resource "aws_api_gateway_method_response" "fetchfilters_MethodResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.fetchfilters_resource.id}"
  http_method = "${aws_api_gateway_method.fetchfilters_method.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "ApiResponse"
  }

  depends_on = [
    "aws_api_gateway_integration.fetchfilters_integration",
    "aws_api_gateway_model.ApiResponse",
  ]
}

resource "aws_api_gateway_method_response" "updatealerts_MethodResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.updatealerts_resource.id}"
  http_method = "${aws_api_gateway_method.updatealerts_method.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "ApiResponse"
  }

  depends_on = [
    "aws_api_gateway_method.updatealerts_method",
    "aws_api_gateway_model.ApiResponse",
  ]
}

resource "aws_api_gateway_method_response" "updatestoredevicelist_MethodResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.updatestoredevicelist_resource.id}"
  http_method = "${aws_api_gateway_method.updatestoredevicelist_method.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "ApiResponse"
  }

  depends_on = [
    "aws_api_gateway_method.updatestoredevicelist_method",
    "aws_api_gateway_model.ApiResponse",
  ]
}

resource "aws_api_gateway_integration_response" "fetchalerts_IntegrationResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.fetchalerts_resource.id}"
  http_method = "${aws_api_gateway_method.fetchalerts_method.http_method}"
  status_code = "${aws_api_gateway_method_response.fetchalerts_MethodResponse.status_code}"

  depends_on = [
    "aws_api_gateway_method_response.fetchalerts_MethodResponse",
  ]
}

resource "aws_api_gateway_integration_response" "fetchfilters_IntegrationResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.fetchfilters_resource.id}"
  http_method = "${aws_api_gateway_method.fetchfilters_method.http_method}"
  status_code = "${aws_api_gateway_method_response.fetchfilters_MethodResponse.status_code}"

  depends_on = [
    "aws_api_gateway_method_response.fetchfilters_MethodResponse",
  ]
}

resource "aws_api_gateway_integration_response" "updatealerts_IntegrationResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.updatealerts_resource.id}"
  http_method = "${aws_api_gateway_method.updatealerts_method.http_method}"
  status_code = "${aws_api_gateway_method_response.updatealerts_MethodResponse.status_code}"

  depends_on = [
    "aws_api_gateway_integration.updatealerts_integration",
  ]
}

resource "aws_api_gateway_integration_response" "updatestoredevicelist_IntegrationResponse" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.updatestoredevicelist_resource.id}"
  http_method = "${aws_api_gateway_method.updatestoredevicelist_method.http_method}"
  status_code = "${aws_api_gateway_method_response.updatestoredevicelist_MethodResponse.status_code}"

  depends_on = [
    "aws_api_gateway_integration.updatestoredevicelist_integration",
  ]
}

resource "aws_api_gateway_deployment" "ReplenAlertAPI_fetchalerts" {
  depends_on  = ["aws_api_gateway_integration.fetchalerts_integration"]
  rest_api_id = "${var.rest_api_id}"
  stage_name  = ""
}

resource "aws_api_gateway_deployment" "ReplenAlertAPI_fetchfilters" {
  depends_on = [
    "aws_api_gateway_integration.fetchfilters_integration",
    "aws_api_gateway_deployment.ReplenAlertAPI_fetchalerts",
  ]

  rest_api_id = "${var.rest_api_id}"
  stage_name  = ""
}

resource "aws_api_gateway_deployment" "ReplenAlertAPI_updatealerts" {
  depends_on = [
    "aws_api_gateway_integration.updatealerts_integration",
    "aws_api_gateway_deployment.ReplenAlertAPI_fetchfilters",
  ]

  rest_api_id = "${var.rest_api_id}"
  stage_name  = ""
}

resource "aws_api_gateway_deployment" "ReplenAlertAPI_updatestoredevicelist" {
  depends_on = [
    "aws_api_gateway_integration.updatestoredevicelist_integration",
    "aws_api_gateway_deployment.ReplenAlertAPI_updatealerts",
  ]

  rest_api_id = "${var.rest_api_id}"
  stage_name  = ""
}

resource "aws_cloudwatch_log_group" "ReplenAlertAPI_log_group" {
  name = "${var.project}-log-group-${var.env}"

  tags {
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  stage_name           = "beta"
  rest_api_id          = "${var.rest_api_id}"
  deployment_id        = "${aws_api_gateway_deployment.ReplenAlertAPI_updatestoredevicelist.id}"
  xray_tracing_enabled = true

  access_log_settings = {
    destination_arn = "${aws_cloudwatch_log_group.ReplenAlertAPI_log_group.arn}"
    format          = "requestId:$context.requestId ip:$context.identity.sourceIp caller:$context.identity.caller user:$context.identity.user requestTime:$context.requestTime httpMethod:$context.httpMethod resourcePath:$context.resourcePath status:$context.status protocol:$context.protocol responseLength:$context.responseLength"
  }

  tags {
    project     = "${var.project}"
    environment = "${var.env}"
    created_by  = "${var.created_by}"
  }
}

resource "aws_api_gateway_method_settings" "fetchalerts_method_settings" {
  rest_api_id = "${var.rest_api_id}"
  stage_name  = "${aws_api_gateway_stage.api_gateway_stage.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled    = true
    logging_level      = "INFO"
    data_trace_enabled = true
  }
}
