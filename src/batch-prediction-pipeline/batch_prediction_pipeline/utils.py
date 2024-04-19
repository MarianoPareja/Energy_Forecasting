import json
import logging
from io import BytesIO
from pathlib import Path
from typing import Optional, Union

import boto3
import botocore
import joblib
import pandas as pd
from batch_prediction_pipeline import settings


def get_logger(name: str) -> logging.Logger:
    """
    Template for getting a logger.

    Args:
        name: Name of the logger.

    Returns: Logger.
    """

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(name)

    return logger


def load_model(model_path: Union[str, Path]):
    """
    Template for loading a model.

    Args:
        model_path: Path to the model.

    Returns: Loaded model.
    """

    return joblib.load(model_path)


def save_json(data: dict, file_name: str, save_dir: str = settings.OUTPUT_DIR):
    """
    Save a dictionary as a JSON file.

    Args:
        data: data to save.
        file_name: Name of the JSON file.
        save_dir: Directory to save the JSON file.

    Returns: None
    """

    data_path = Path(save_dir) / file_name
    with open(data_path, "w") as f:
        json.dump(data, f)


def load_json(file_name: str, save_dir: str = settings.OUTPUT_DIR) -> dict:
    """
    Load a JSON file.

    Args:
        file_name: Name of the JSON file.
        save_dir: Directory of the JSON file.

    Returns: Dictionary with the data.
    """

    data_path = Path(save_dir) / file_name
    with open(data_path, "r") as f:
        return json.load(f)


def write_object_to(
    object_name: str,
    data: pd.DataFrame,
    bucket_name: str = settings.SETTINGS["AWS_BUCKET_NAME"],
):
    """Write a dataframe to a GCS bucket as a parquet file.

    Args:
        bucket (google.cloud.storage.Bucket): The bucket to write to.
        object_name (str): The name of the object to write to. Must be a parquet file.
        data (pd.DataFrame): The dataframe to write to GCS.
    """

    buffer = BytesIO()
    data.to_parquet(buffer, engine="pyarrow")
    buffer.seek(0)

    s3 = boto3.client("s3")
    s3.upload_fileobj(buffer, bucket_name, object_name)


def read_object_from(
    object_name: str,
    bucket_name: str = settings.SETTINGS["AWS_BUCKET_NAME"],
) -> Optional[pd.DataFrame]:
    """Reads a object from a bucket and returns a dataframe.

    Args:
        bucket: The bucket to read from.
        object_name: The name of the object to read.

    Returns:
        A dataframe containing the data from the object.
    """

    try:
        s3_client = boto3.client("s3")

        s3_object = s3_client.get_object(Bucket=bucket_name, Key=object_name)

        # Download the object data as a bytes object
        parquet_data = s3_object["Body"].read()

        # Read the Parquet data into a Pandas DataFrame
        return pd.read_parquet(BytesIO(parquet_data))

    except botocore.exceptions.ClientError as error:
        # Handle potential errors gracefully
        print(f"Error reading Parquet file from S3: {error}")
        return None
