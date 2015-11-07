Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "lists#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root "high_voltage/pages#show", id: "landing"
  end

  resources :lists, only: [:index, :create, :show] do
    resources :people, only: [:new, :create]
  end
end
