import os
import warnings
from pathlib import Path
from typing import Union

from batch_prediction_pipeline import utils
from dotenv import load_dotenv

ENV_VARIABLES = [
    "FS_API_KEY",
    "FS_PROJECT_NAME",
    "WANDB_API_KEY",
    "WANDB_ENTITY",
    "WANDB_PROJECT",
]

logger = utils.get_logger(__name__)

warnings.filterwarnings(action="ignore", category=FutureWarning, module="sktime")


def load_env_vars(root_dir: Union[str, Path]) -> dict:
    """
    Load environment variables from .env.default and .env files.

    Args:
        root_dir: Root directory of the .env files.

    Returns:
        Dictionary with the environment variables.
    """

    if isinstance(root_dir, str):
        root_dir = Path(root_dir)

    if os.path.exists(os.path.join(root_dir, ".env")):
        logger.info("Loading .env file")
        load_dotenv(dotenv_path=root_dir / ".env", override=True)

    for env_var in ENV_VARIABLES:
        if env_var not in os.environ:
            logger.error("{env_var} must be defined in the environment")

    return dict(os.environ)


def get_root_dir(default_value: str = ".") -> Path:
    """
    Get the root directory of the project.

    Args:
        default_value: Default value to use if the environment variable is not set.

    Returns:
        Path to the root directory of the project.
    """

    return Path(os.getenv("ML_PIPELINE_ROOT_DIR", default_value))


# The settings will be loaded and the outputs will be saved relative to the 'ML_PIPELINE_ROOT_DIR' directory.
ML_PIPELINE_ROOT_DIR = get_root_dir()
OUTPUT_DIR = ML_PIPELINE_ROOT_DIR / "output"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

SETTINGS = load_env_vars(root_dir=ML_PIPELINE_ROOT_DIR)
