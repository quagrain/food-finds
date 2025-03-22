# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Admins(models.Model):
    id = models.OneToOneField('Users', models.DO_NOTHING, db_column='id', primary_key=True)
    school = models.OneToOneField('Schools', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'admins'


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class CartItems(models.Model):
    cart = models.ForeignKey('Carts', models.DO_NOTHING)
    menu_item = models.ForeignKey('MenuItems', models.DO_NOTHING)
    quantity = models.IntegerField()
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'cart_items'


class Carts(models.Model):
    student = models.ForeignKey('Students', models.DO_NOTHING)
    vendor = models.ForeignKey('Vendors', models.DO_NOTHING)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'carts'
        unique_together = (('student', 'vendor'),)


class Categories(models.Model):
    category = models.CharField(max_length=100)
    school = models.ForeignKey('Schools', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'categories'
        unique_together = (('category', 'school'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class FavoriteMenuItems(models.Model):
    student = models.OneToOneField('Students', models.DO_NOTHING, primary_key=True)  # The composite primary key (student_id, menu_item_id) found, that is not supported. The first column is selected.
    menu_item = models.ForeignKey('MenuItems', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'favorite_menu_items'
        unique_together = (('student', 'menu_item'),)


class FavoriteVendors(models.Model):
    student = models.OneToOneField('Students', models.DO_NOTHING, primary_key=True)  # The composite primary key (student_id, vendor_id) found, that is not supported. The first column is selected.
    vendor = models.ForeignKey('Vendors', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'favorite_vendors'
        unique_together = (('student', 'vendor'),)


class MenuItemRatings(models.Model):
    student = models.ForeignKey('Students', models.DO_NOTHING)
    menu_item = models.ForeignKey('MenuItems', models.DO_NOTHING)
    rating = models.IntegerField()
    review = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'menu_item_ratings'
        unique_together = (('student', 'menu_item'),)


class MenuItems(models.Model):
    vendor = models.ForeignKey('Vendors', models.DO_NOTHING)
    category = models.ForeignKey(Categories, models.DO_NOTHING, blank=True, null=True)
    meal_name = models.CharField(max_length=255)
    meal_description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    image_url = models.TextField(blank=True, null=True)
    is_available = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'menu_items'


class OrderItems(models.Model):
    order = models.ForeignKey('Orders', models.DO_NOTHING)
    menu_item = models.ForeignKey(MenuItems, models.DO_NOTHING)
    quantity = models.IntegerField()
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    special_instructions = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'order_items'


class OrderRatings(models.Model):
    student = models.ForeignKey('Students', models.DO_NOTHING)
    order = models.ForeignKey('Orders', models.DO_NOTHING)
    rating = models.IntegerField()
    review = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'order_ratings'
        unique_together = (('student', 'order'),)


class Orders(models.Model):
    student = models.ForeignKey('Students', models.DO_NOTHING)
    vendor = models.ForeignKey('Vendors', models.DO_NOTHING)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    order_status = models.CharField(max_length=20)
    special_instructions = models.TextField(blank=True, null=True)
    delivery_location = models.TextField(blank=True, null=True)
    placed_at = models.DateTimeField(blank=True, null=True)
    completed_at = models.DateTimeField(blank=True, null=True)
    delivered_at = models.DateTimeField(blank=True, null=True)
    cancelled_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'orders'


class Reports(models.Model):
    reporter = models.ForeignKey('Users', models.DO_NOTHING)
    reported = models.ForeignKey('Users', models.DO_NOTHING, related_name='reports_reported_set')
    report_reason = models.TextField(blank=True, null=True)
    report_status = models.CharField(max_length=20)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'reports'


class Schools(models.Model):
    school_name = models.CharField(max_length=255)
    email_domain = models.CharField(max_length=255)
    logo_url = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'schools'


class SpecialOffers(models.Model):
    vendor = models.ForeignKey('Vendors', models.DO_NOTHING)
    menu_item = models.ForeignKey(MenuItems, models.DO_NOTHING)
    offer_description = models.TextField(blank=True, null=True)
    discount_type = models.CharField(max_length=10)
    discount = models.DecimalField(max_digits=10, decimal_places=2)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'special_offers'


class Students(models.Model):
    id = models.OneToOneField('Users', models.DO_NOTHING, db_column='id', primary_key=True)
    profile_image_url = models.TextField(blank=True, null=True)
    default_delivery_location = models.TextField(blank=True, null=True)
    dietary_preferences = models.TextField(blank=True, null=True)
    notification_preferences = models.JSONField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'students'


class Users(models.Model):
    school = models.ForeignKey(Schools, models.DO_NOTHING)
    email = models.CharField(max_length=255)
    pwd_hash = models.CharField(max_length=255)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=20)
    user_type = models.CharField(max_length=20)
    is_blocked = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users'


class VendorRatings(models.Model):
    student = models.ForeignKey(Students, models.DO_NOTHING)
    vendor = models.ForeignKey('Vendors', models.DO_NOTHING)
    rating = models.IntegerField()
    review = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vendor_ratings'
        unique_together = (('student', 'vendor'),)


class Vendors(models.Model):
    id = models.OneToOneField(Users, models.DO_NOTHING, db_column='id', primary_key=True)
    vendor_name = models.CharField(max_length=255)
    vendor_contact = models.CharField(max_length=20)
    logo_url = models.TextField(blank=True, null=True)
    business_address = models.TextField(blank=True, null=True)
    business_description = models.TextField(blank=True, null=True)
    business_days = models.JSONField(blank=True, null=True)
    open_time = models.TimeField()
    close_time = models.TimeField()
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vendors'
