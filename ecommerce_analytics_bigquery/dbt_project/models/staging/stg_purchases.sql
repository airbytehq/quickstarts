select
    id,
    user_id,
    product_id,
    updated_at,
    purchased_at,
    returned_at,
    created_at,
    added_to_cart_at,
    _airbyte_emitted_at,
    _airbyte_normalized_at
from {{ source('faker', 'purchases') }}
