Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_for :users
	root "homes#top"
	get "home/about"=>"homes#about"

	resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
		resources :book_comments, only: [:create, :destroy]
		resource :favorite, only: [:create, :destroy]
	end
	resources :users, only: [:index,:show,:edit,:update] do
		resource :relationships, only: [:create, :destroy]
		get 'follows' => 'users#follows', as: 'follows'
		get 'followers' => 'users#followers', as: 'followers'
	end

	get "search" => "searches#search"
	get 'users/:user_id/book_count' => 'users#count_search', as: 'count_search'

	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
