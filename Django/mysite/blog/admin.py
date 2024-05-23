from django.contrib import admin
from .models import *

admin.site.register(User)
admin.site.register(Profile)
admin.site.register(Tag)

# admin사이트 커스터마이징 방법1
class PostAdmin(admin.ModelAdmin):
    list_display = ['id', 'title']
    list_display_links = ['id', 'title']
    # 정렬
    ordering = ['title'] # title로 내림차순
    list_filter = ['tag']
    # 검색
    search_fields = ['body'] # body필드 안 내용으로 검색
    list_per_page = 3 # 페이지네이션

admin.site.register(Post, PostAdmin)

# admin사이트 커스터마이징 방법2
def make_deleted(modeladmin, request, queryset):
    queryset.update(deleted=True)
    make_deleted.short_description = '선택된 comments를 삭제상태로 설정합니다.'

@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ['post', 'author', 'message_length', 'deleted']
    actions = [make_deleted]
    
    # 댓글의 글자수를 세고, message_length에 출력
    def message_length(self, obj):
        return len(obj.message)
    
    message_length.short_description = '댓글 글자수'