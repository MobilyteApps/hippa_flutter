class ForgotPasswordResponse {
	int? status;
	Data? data;
	String? message;

	ForgotPasswordResponse({ this.status, this.data,  this.message});

	ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
		status = json['status'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = this.status;
		if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
		data['message'] = this.message;
		return data;
	}
}

class Data {


	Data();
	Data.fromJson(Map<String, dynamic> json) {
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}
