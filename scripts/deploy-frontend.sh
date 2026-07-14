#!/bin/bash

set -e


echo "Building frontend application..."


cd ../frontend


npm ci


npm run build


echo "Uploading frontend files to S3..."


aws s3 sync dist/ s3://REPLACE_WITH_FRONTEND_BUCKET --delete



echo "Invalidating CloudFront cache..."


aws cloudfront create-invalidation \
--distribution-id REPLACE_WITH_CLOUDFRONT_DISTRIBUTION_ID \
--paths "/*"



echo "Frontend deployment completed successfully."
