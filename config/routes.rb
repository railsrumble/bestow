Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "lists#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root "high_voltage/pages#show", id: "landing"
  end

  resources :lists, only: [:index, :create, :show] do
    resources :invitations, only: [:create], shallow: true do
      resources :acceptances, only: [:new, :create]
    end
    resources :people, only: [:index, :new, :create, :show] do
      resources :purchased_gifts, only: [:new, :create]
    end
  end
end
