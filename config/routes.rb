Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "people#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root "high_voltage/pages#show", id: "landing"
  end

  resources :people, only: [:index, :new, :create]
end
