select
    id,
    gender,
    academic_degree,
    title,
    nationality,
    age,
    name,
    email,
    created_at,
    updated_at,
    _airbyte_extracted_at,
from {{ source('faker', 'users') }}
