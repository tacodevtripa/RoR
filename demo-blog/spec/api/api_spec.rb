# spec/requests/blogs_spec.rb
require 'swagger_helper'

describe 'Blog API' do
  fixtures :users, :posts, :comments # Load users and posts from fixtures

  let(:user) { users(:one) }
  let(:post) { posts(:one) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }
  path '/api/v1/user/{id}/show_posts' do
    get 'Get all posts for a user' do
      tags 'Posts'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :Authorization, in: :header, type: :string, description: "JWT Token", required: true

       response '200', 'blog found' do
        schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            author_id: { type: :integer },
            text: { type: :string }
          },
          required: [ 'id', 'author_id', 'text' ]
        }
        let(:id) { post.id }
        run_test!
      end

      # response '422', 'invalid request' do
      #   let(:blog) { { title: 'foo' } }
      #   run_test!
      # end
    end
  end

  # path '/blogs/{id}' do
  #   get 'Retrieves a blog' do
  #     tags 'Blogs', 'Another Tag'
  #     produces 'application/json', 'application/xml'
  #     parameter name: :id, in: :path, type: :string
  #     request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

  #     response '200', 'blog found' do
  #       schema type: :object,
  #         properties: {
  #           id: { type: :integer },
  #           title: { type: :string },
  #           content: { type: :string }
  #         },
  #         required: [ 'id', 'title', 'content' ]

  #       let(:id) { Blog.create(title: 'foo', content: 'bar').id }
  #       run_test!
  #     end

  #     response '404', 'blog not found' do
  #       let(:id) { 'invalid' }
  #       run_test!
  #     end

  #     response '406', 'unsupported accept header' do
  #       let(:'Accept') { 'application/foo' }
  #       run_test!
  #     end
  #   end
  # end
end
