import 'dart:io';

import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/enums/update_state_type.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/features/blog/data/models/blog_category_model.dart';
import 'package:bloc_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> updateBlog(BlogModel blogModel);

  Future<String> updateBlogImage({
    required File image,
    required BlogModel blogModel,
  });

  Future<List<BlogModel>> getBlogs({required int page, int itemPerPage = 10});

  Future<List<BlogModel>> getBlogsByUserId(String userId);

  Future<List<BlogModel>> getBlogsByKeyWord({required String keyword, required int page, int itemPerPage = 10, required List<String> filterCategories});

  Future<LikeState> getBlogLikeState(String blogId, String userId);

  Future<LikeState> updateBlogLikeState(
    String blogId,
    String userId,
    UpdateStateType type,
  );

  Future<List<BlogModel>> getFavoriteBlogs(String userId);

  Future<List<BlogCategoryModel>> getBlogCategories();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> updateBlog(BlogModel blogModel) async {
    try {
      final blogData =
          await supabaseClient
              .from('blogs')
              .insert(blogModel.toJson())
              .select();
      return BlogModel.fromJson(blogData.first);
    } on StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> updateBlogImage({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      await supabaseClient.storage
          .from(AppConstants.bucketBlogImages)
          .upload(blogModel.id, image);
      return supabaseClient.storage
          .from(AppConstants.bucketBlogImages)
          .getPublicUrl(blogModel.id);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogs({required int page, int itemPerPage = 10}) async {
    try {
      final start = (page - 1) * itemPerPage;
      final end = start + itemPerPage - 1;
      final blogs = await supabaseClient
          .from(AppConstants.tableBlogs)
          .select('*, profiles (name, image_url)')
          .range(start, end)
          .order('updated_at');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
              posterImage: blog['profiles']['image_url'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogsByUserId(String userId) async {
    try {
      final blogs = await supabaseClient
          .from(AppConstants.tableBlogs)
          .select('*, profiles (name, image_url)')
          .eq("poster_id", userId)
          .order('updated_at');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
              posterImage: blog['profiles']['image_url'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogsByKeyWord({required String keyword, required int page, int itemPerPage = 10, required List<String> filterCategories}) async {
    try {
      final start = (page - 1) * itemPerPage;
      final end = start + itemPerPage - 1;
      final query = supabaseClient
          .from(AppConstants.tableBlogs)
          .select('*, profiles (name, image_url)')
          .ilike("title", '%$keyword%');

      if(filterCategories.isNotEmpty){
        query.inFilter("category_ids", filterCategories);
      }

      final blogs = await query.range(start, end).order('updated_at');

      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
              posterImage: blog['profiles']['image_url'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<LikeState> getBlogLikeState(String blogId, String userId) async {
    try {
      final data =
          await supabaseClient
              .from(AppConstants.tableLikes)
              .select('id')
              .eq('blog_id', blogId)
              .eq('user_id', userId)
              .limit(1)
              .maybeSingle();
      return data != null ? LikeState.liked : LikeState.unliked;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<LikeState> updateBlogLikeState(
    String blogId,
    String userId,
    UpdateStateType type,
  ) async {
    try {
      dynamic response;
      if (type == UpdateStateType.setLike) {
        // Here is insert like record
        response = await supabaseClient
            .from(AppConstants.tableLikes)
            .insert({"blog_id": blogId, "user_id": userId})
            .select("id");
        return response != null ? LikeState.liked : LikeState.unknown;
      } else {
        // Here is remove like record
        response = await supabaseClient
            .from(AppConstants.tableLikes)
            .delete()
            .eq('blog_id', blogId)
            .eq('user_id', userId)
            .select("id");
      }
      return response != null ? LikeState.unliked : LikeState.unknown;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getFavoriteBlogs(String userId) async {
    try {
      final response = await supabaseClient
          .from(AppConstants.tableLikes)
          .select('blog_id, blogs(*, profiles (name, image_url))')
          .eq('user_id', userId);
      return response
          .map(
            (data) => BlogModel.fromJson(data['blogs']).copyWith(
              posterName: data['blogs']['profiles']['name'],
              posterImage: data['blogs']['profiles']['image_url'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogCategoryModel>> getBlogCategories() async {
    try {
      final response = await supabaseClient
          .from(AppConstants.tableCategories)
          .select('*');
      return response.map((data) => BlogCategoryModel.fromJson(data)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
