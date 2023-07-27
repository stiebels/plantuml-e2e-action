import pandas as pd


class SomeClass:
	def __init__(self, name: str):
		self.name = name

	def get_name(self) -> str:
		return self.name

	def create_dummy_df(self) -> pd.DataFrame:
		return pd.DataFrame({self.name: [1, 2, 3]})
