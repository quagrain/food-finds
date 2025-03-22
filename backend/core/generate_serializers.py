from django.apps import apps

with open("serializers.py", "w") as f:
    f.write("from rest_framework import serializers\n")
    f.write("from .models import *\n\n")

    for model in apps.get_app_config('core').get_models():
        model_name = model.__name__
        f.write(f"class {model_name}Serializer(serializers.ModelSerializer):\n")
        f.write(f"    class Meta:\n")
        f.write(f"        model = {model_name}\n")
        f.write(f"        fields = '__all__'\n\n")

print("serializers.py generated successfully!")
