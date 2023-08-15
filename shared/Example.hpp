#pragma once

class Example
{
public:
	Example(const int& val);

	const int& val() const;
	void val(const int& val);

private:
	int m_val;
};
