from django.contrib import admin
from .models import *

admin.site.register(Comment)
admin.site.register(User)
admin.site.register(Profile)
admin.site.register(Tag)

# admin사이트 커스터마이징
class PostAdmin(admin.ModelAdmin):
    list_display = ['id', 'title']
    list_display_links = ['id', 'title']
    # 정렬
    ordering = ['title'] # title로 내림차순
    list_filter = ['tag']
    # 검색
    search_fields = ['body'] # body필드 안 내용으로 검색
    list_per_page = 3

admin.site.register(Post, PostAdmin)