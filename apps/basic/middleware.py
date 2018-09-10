from django.utils.deprecation import MiddlewareMixin

import datetime
import uuid


class CustomMiddleware(MiddlewareMixin):

    @staticmethod
    def process_response(request, response):
        if not request.COOKIES.get('client_id', None):
            max_age = 365 * 24 * 60 * 60  # 10 years
            expires = datetime.datetime.utcnow() + datetime.timedelta(seconds=max_age)
            client_id = uuid.uuid4()
            response.set_cookie('client_id', client_id, expires=expires)
        return response
